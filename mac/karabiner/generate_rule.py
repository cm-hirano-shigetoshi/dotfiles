import json
import sys
from dataclasses import dataclass, field

MAPPING_FROM = "US"
MAPPING_TO = "JIS"

INTERNAL_KEY = {
    "US": {
        "-": "hyphen",
        "=": "equal_sign",
        ";": "semicolon",
        ":": "quote",
        "[": "close_bracket",
        "]": "backslash",
        "\\": "international3",
        ",": "comma",
        ".": "period",
        "/": "slash",
        "`": "grave_accent_and_tilde",
        "'": "S-7",
        "@": "open_bracket",
        "-": "hyphen",
        "enter": "return_or_enter",
        "space": "spacebar",
        "eisuu": "japanese_eisuu",
        "kana": "japanese_kana",
        "katakana": "japanese_pc_katakana",
        "backspace": "delete_or_backspace",
    },
    "JIS": {
        "!": "S-1",
        '"': "S-2",
        "#": "S-3",
        "$": "S-4",
        "%": "S-5",
        "&": "S-6",
        "'": "S-7",
        "(": "S-8",
        ")": "S-9",
        "@": "open_bracket",
        "^": "equal_sign",
        "*": "S-quote",
        "-": "hyphen",
        "_": "international1",
        ";": "semicolon",
        "=": "S-hyphen",
        "+": "S-semicolon",
        ":": "quote",
        "~": "S-equal_sign",
        "[": "close_bracket",
        "]": "backslash",
        "{": "S-close_bracket",
        "}": "S-backslash",
        "|": "S-international3",
        "<": "S-comma",
        ">": "S-period",
        "?": "S-slash",
        "`": "grave_accent_and_tilde",
        "\\": "international3",
        "enter": "return_or_enter",
        "space": "spacebar",
        "backspace": "delete_or_backspace",
        "eisuu": "japanese_eisuu",
        "kana": "japanese_kana",
        "delete": "delete_forward",
        "mouse_left_click": "button1",
    },
}


def read_input(input_path):
    with open(input_path) as f:
        lines = [
            l.rstrip("\n") for l in f.readlines() if not l.lstrip().startswith("#")
        ]
    lines = [l for l in lines if not l.lstrip().startswith("#")]
    lines = [l for l in lines if len(l.strip()) > 0]
    return lines


@dataclass
class Name:
    name: str


@dataclass
class From:
    key: str
    mod: list
    vmods: list

    def __init__(self, key, mod="", vmods=""):
        def has_shift(mod):
            return "S" in mod

        def has_control(mod):
            return "c" in mod

        def has_option(mod):
            return "O" in mod

        def has_command(mod):
            return "C" in mod

        self.key = key
        self.mod = []
        self.vmods = vmods.split(",") if vmods else []
        if has_shift(mod):
            self.mod.append("shift")
        if has_control(mod):
            self.mod.append("control")
        if has_option(mod):
            self.mod.append("option")
        if has_command(mod):
            self.mod.append("command")

    def _generate_modifiers(self):
        if "shift" in self.mod:
            return {"mandatory": self.mod, "optional": ["any"]}
        else:
            return {"mandatory": self.mod, "optional": ["control", "option", "command"]}

    def asdict(self):
        key_or_mouse = (
            "pointing_button" if self.key.startswith("mouse_") else "key_code"
        )
        return {
            key_or_mouse: INTERNAL_KEY[MAPPING_FROM].get(self.key, self.key),
            "modifiers": self._generate_modifiers(),
        }


@dataclass
class VMod:
    name: str


@dataclass
class Shell:
    cmd: str


@dataclass
class To:
    key: str | VMod | Shell
    mod: list

    def __init__(self, key, mod=""):
        def has_shift(mod):
            return "S" in mod

        def has_control(mod):
            return "c" in mod

        def has_option(mod):
            return "O" in mod

        def has_command(mod):
            return "C" in mod

        self.key = key
        self.mod = []
        if has_shift(mod):
            self.mod.append("shift")
        if has_control(mod):
            self.mod.append("control")
        if has_option(mod):
            self.mod.append("option")
        if has_command(mod):
            self.mod.append("command")

    def asdict(self):
        if isinstance(self.key, VMod):
            return {"set_variable": {"name": self.key.name, "value": 1}}
        elif isinstance(self.key, Shell):
            return {"shell_command": self.key.cmd}
        else:
            key_mod = INTERNAL_KEY[MAPPING_TO].get(self.key, self.key)
            key_or_mouse = (
                "pointing_button" if self.key.startswith("mouse_") else "key_code"
            )
            if key_mod[:2] == "S-":
                mod = self.mod + ["shift"]
                return {key_or_mouse: key_mod[2:], "modifiers": mod}
            else:
                return {key_or_mouse: key_mod, "modifiers": self.mod}

    def asdict_to_after_key_up(self):
        if isinstance(self.key, VMod):
            return {"set_variable": {"name": self.key.name, "value": 0}}


@dataclass
class ToAlone:
    key: VMod | str
    mod: list

    def __init__(self, key, mod=""):
        def has_shift(mod):
            return "S" in mod

        def has_control(mod):
            return "c" in mod

        def has_option(mod):
            return "O" in mod

        def has_command(mod):
            return "C" in mod

        self.key = key
        self.mod = []
        if has_shift(mod):
            self.mod.append("shift")
        if has_control(mod):
            self.mod.append("control")
        if has_option(mod):
            self.mod.append("option")
        if has_command(mod):
            self.mod.append("command")

    def asdict(self):
        if isinstance(self.key, VMod):
            return {"set_variable": {"name": self.key.name, "value": 1}}
        else:
            key_mod = INTERNAL_KEY[MAPPING_TO].get(self.key, self.key)
            key_or_mouse = (
                "pointing_button" if self.key.startswith("mouse_") else "key_code"
            )
            if key_mod[:2] == "S-":
                mod = self.mod + ["shift"]
                return {key_or_mouse: key_mod[2:], "modifiers": mod}
            else:
                return {key_or_mouse: key_mod, "modifiers": self.mod}


@dataclass
class Condition:
    type_: str
    condition: dict | list

    def asdict(self):
        if self.type_ == "device":
            if type(self.condition) == list:
                return {"identifiers": self.condition, "type": "device_if"}
            elif type(self.condition) == dict:
                return {"identifiers": [self.condition], "type": "device_if"}
        elif self.type_ == "variable":
            return {
                "type": "variable_if",
                "name": self.condition["vmod_name"],
                "value": 1,
            }
        elif self.type_ == "application":
            return {
                "type": "frontmost_application_if",
                "bundle_identifiers": self.condition["bundle_identifiers"],
            }


@dataclass
class Binding:
    description: Name
    from_: From
    to: list
    to_alone: list
    conditions: list = field(default_factory=list)
    type_: str = "basic"

    def asdict(self):
        def add_condition(manipulators, conditions, from_):
            if self.from_.vmods:
                conditions.extend(
                    [
                        Condition("variable", {"vmod_name": vmod_name})
                        for vmod_name in from_.vmods
                    ]
                )
            manipulators["conditions"] = [c.asdict() for c in conditions]

        def add_from(manipulators, from_):
            from_dict = from_.asdict()
            if self.from_.vmods:
                from_dict["modifiers"]["optional"] = ["any"]
            manipulators["from"] = from_dict

        def add_to(manipulators, to):
            manipulators["to"] = [t.asdict() for t in to]
            manipulators["to_after_key_up"] = [
                t.asdict_to_after_key_up() for t in to if isinstance(t.key, VMod)
            ]

        def add_to_if_alone(manipulators, to_alone):
            manipulators["to_if_alone"] = [t.asdict() for t in to_alone]

        """
        conditions = self.conditions
        from_ = self.from_.asdict()
        if self.from_.vmods:
            conditions.extend(
                [
                    Condition("variable", {"vmod_name": vmod_name})
                    for vmod_name in self.from_.vmods
                ]
            )
            from_["modifiers"]["optional"] = ["any"]
        """
        manipulators = {}
        add_condition(manipulators, self.conditions, self.from_)
        add_from(manipulators, self.from_)
        add_to(manipulators, self.to)
        add_to_if_alone(manipulators, self.to_alone)
        manipulators["type"] = self.type_
        """
        manipulators = {
            "conditions": [c.asdict() for c in conditions],
            "from": from_,
            "to": [t.asdict() for t in self.to],
            "to_if_alone": [t.asdict() for t in self.to_alone],
            "to_after_key_up": []
            "type": self.type_,
        }
        """
        return {"description": self.description.name, "manipulators": [manipulators]}


@dataclass
class VirtualModifier:
    description: Name
    from_: From
    vmods: list
    conditions: list = field(default_factory=list)
    type_: str = "basic"

    def asdict(self):
        from_ = self.from_.asdict()
        from_["modifiers"]["optional"] = ["any"]
        to = []
        to_after_key_up = []
        for vmod in self.vmods:
            to.append({"set_variable": {"name": vmod.name, "value": 1}})
            to_after_key_up.append({"set_variable": {"name": vmod.name, "value": 0}})
        manipulator = {
            "conditions": [c.asdict() for c in self.conditions],
            "from": from_,
            "to": to,
            "to_after_key_up": to_after_key_up,
            "type": self.type_,
        }
        return {"description": self.description.name, "manipulators": [manipulator]}


def generat_modification(line):
    import sys

    def get_objects(line):
        """
        Name
        From
        [To]
        [ToAlone]
        [VMod]
        [Condition]
        """
        objects = {}
        for x in line.split("\t"):
            if len(x.strip()) <= 0:
                continue
            obj = eval(x)
            if isinstance(obj, Name):
                objects["Name"] = obj
            if isinstance(obj, From):
                objects["From"] = obj
            if isinstance(obj, To):
                objects.setdefault("To", []).append(obj)
            if isinstance(obj, ToAlone):
                objects.setdefault("ToAlone", []).append(obj)
            if isinstance(obj, VMod):
                objects.setdefault("VMod", []).append(obj)
            if isinstance(obj, Condition):
                objects.setdefault("Condition", []).append(obj)
        return objects

    def is_from_to(objects):
        return "From" in objects and "To" in objects

    def is_from_vmod(objects):
        return "From" in objects and "VMod" in objects

    o = get_objects(line)
    if is_from_to(o):
        return Binding(
            description=o["Name"],
            from_=o["From"],
            to=o["To"],
            to_alone=o.get("ToAlone", []),
            conditions=o.get("Condition", []),
        ).asdict()
    elif is_from_vmod(o):
        return VirtualModifier(
            description=o["Name"],
            from_=o["From"],
            vmods=o["VMod"],
            conditions=o.get("Condition", []),
        ).asdict()


def main():
    lines = read_input(sys.argv[1])
    modifications = []
    for line in lines:
        modification = generat_modification(line)
        modifications.append(modification)
    print(json.dumps(modifications))


if __name__ == "__main__":
    main()
