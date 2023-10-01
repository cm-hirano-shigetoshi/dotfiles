#include QMK_KEYBOARD_H
#include "keymap_japanese.h"


enum layer_names {
    _QWERTY,
    _LOWER,
    _RAISE,
    _LEFT
};

enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  LOWER,
  RAISE,
  LEFT,
};

#define EISU LALT(KC_GRV)

const key_override_t underscore_key_override = ko_make_basic(MOD_MASK_SHIFT, JP_COLN, KC_F21);

const key_override_t **key_overrides = (const key_override_t *[]){
    &underscore_key_override,
    NULL
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  /* Qwerty
   * ,----------------------------------------------------------------------------------------------------------------------.
   * | ESC  |   1  |   2  |   3  |   4  |   5  |   [  |                    |   ]  |   6  |   7  |   8  |   9  |   0  |Pscree|
   * |------+------+------+------+------+------+------+--------------------+------+------+------+------+------+------+------|
   * |  `   |   Q  |   W  |   E  |   R  |   T  |   -  |                    |   =  |   Y  |   U  |   I  |   O  |   P  |  \   |
   * |------+------+------+------+------+------+------+--------------------+------+------+------+------+------+------+------|
   * | Tab  |   A  |   S  |   D  |   F  |   G  |  Del |                    | Bksp |   H  |   J  |   K  |   L  |   ;  |  "   |
   * |------+------+------+------+------+------+---------------------------+------+------+------+------+------+------+------|
   * | Shift|   Z  |   X  |   C  |   V  |   B  | Space|                    | Enter|   N  |   M  |   ,  |   .  |   /  | Shift|
   * |-------------+------+------+------+------+------+------+------+------+------+------+------+------+------+-------------|
   * | Ctrl |  GUI |  ALt | EISU |||||||| Lower| Space|  Del |||||||| Bksp | Enter| Raise|||||||| Left | Down |  Up  | Right|
   * ,----------------------------------------------------------------------------------------------------------------------.

  [_QWERTY] = LAYOUT(
    KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_LBRC,                        KC_RBRC, KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_PSCR,
    KC_GRV,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_MINS,                        KC_EQL , KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
    KC_TAB,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_DEL ,                        KC_BSPC, KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_SPC ,                        KC_ENT , KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
    KC_LCTL, KC_LGUI, KC_LALT, EISU,             LOWER,   KC_SPC ,KC_DEL,         KC_BSPC,KC_ENT , RAISE,            KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT
    RAISE,   XXXXXXX, KC_LALT, KC_LGUI, JP_MHEN, LT(LOWER, KC_SPC), XXXXXXX, XXXXXXX, LT(LOWER, KC_ENT), KC_SPC,  RSFT_T(JP_HENK),  KC_APP,  XXXXXXX, XXXXXXX
  ),
   */

  [_QWERTY] = LAYOUT(
    KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_VOLU,                               KC_BRIU, KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
    KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_VOLD,                               KC_BRID, KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    JP_MINS,
    KC_LCTL, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_MUTE,                               XXXXXXX, KC_H,    KC_J,    KC_K,    KC_L,    JP_COLN, JP_LBRC,
    KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    XXXXXXX,                               XXXXXXX, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, JP_RBRC,
    RAISE,   XXXXXXX, KC_LALT, KC_LGUI, JP_MHEN, LT(LOWER, KC_SPC), XXXXXXX,  XXXXXXX, LT(LOWER, KC_ENT), KC_SPC,  RSFT_T(JP_HENK),  KC_APP,  XXXXXXX, XXXXXXX
  ),

  [_LOWER] = LAYOUT(
    XXXXXXX, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_MPLY,                        _______, KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  _______,
    KC_BSPC, KC_EXLM, JP_DQUO, KC_HASH, KC_DLR,  KC_PERC, _______,                        _______, JP_AMPR, JP_QUOT, JP_ASTR, JP_PLUS, JP_TILD, KC_DEL,
    _______, KC_1   , KC_2   , KC_3   , KC_4   , KC_5   , _______,                        _______, KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , JP_PIPE,
    _______, JP_COLN, JP_AT,   KC_MINS, KC_SLSH, KC_DOT , _______,                        _______, KC_EQL,  KC_GRV,  JP_LPRN, JP_RPRN, JP_YEN,  JP_UNDS,
    _______, _______, _______, _______,          _______, _______, _______,      _______, _______, _______,          _______, _______, _______, _______
  ),

  [_RAISE] = LAYOUT(
    XXXXXXX, _______, _______, _______, _______, _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, _______, KC_F19,  _______, KC_F20,  _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, _______, KC_F16,  KC_F18,  KC_F17,  _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    XXXXXXX, _______, _______, _______,          _______, KC_ENT,  _______,      _______, _______, _______,          _______, _______, _______, _______
  ),

  [_LEFT] = LAYOUT(
    _______, _______, _______, _______, _______, _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, KC_1   , KC_2   , KC_3   , KC_4   , KC_5   , _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______,                        _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______,          _______, KC_ENT , _______,      _______, _______, _______,          _______, _______, _______, _______
  )
};

#ifdef AUDIO_ENABLE
float tone_qwerty[][2]     = SONG(QWERTY_SOUND);
#endif

void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
         print("mode just switched to qwerty and this is a huge string\n");
        set_single_persistent_default_layer(_QWERTY);
      }
      return false;
      break;
    case LOWER:
      if (record->event.pressed) {
        layer_on(_LOWER);
        update_tri_layer(_LOWER, _RAISE, _LEFT);
      } else {
        layer_off(_LOWER);
        update_tri_layer(_LOWER, _RAISE, _LEFT);
      }
      return false;
      break;
    case RAISE:
      if (record->event.pressed) {
        layer_on(_RAISE);
        update_tri_layer(_LOWER, _RAISE, _LEFT);
      } else {
        layer_off(_RAISE);
        update_tri_layer(_LOWER, _RAISE, _LEFT);
      }
      return false;
      break;
    case LEFT:
      if (record->event.pressed) {
        layer_on(_LEFT);
      } else {
        layer_off(_LEFT);
      }
      return false;
      break;
  }
  return true;
}
