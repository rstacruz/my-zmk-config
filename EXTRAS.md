# Extras

Some other things I tried but ultimately decided against.

## Right-handed numpad

```c
    hex_layer { // Hex input (orthodox)
      // ┌─────────────────────┬─────────────────────┐
      // │     ,   .   :   #   │ 1   2   3   ⌫   ▓▓  │
      // │ a   b   c   d   e   │ 4   5   6           │
      // │ f   +   -   *   /   │ 7   8   9           │
      // └─────────────────────┴─────────────────────┘
      //         │         ␣   │ 0   ↵       │
      //         └─────────────┴─────────────┘ 
      bindings = <
        &none     &kp COMMA &kp DOT     &kp COLON &kp HASH     &kp N1    &kp N2    &kp N3    &kp BSPC  &none
        &kp A     &kp B     &kp C       &kp D     &kp E        &kp N4    &kp N5    &kp N6    &none     &none
        &kp F     &kp PLUS  &kp MINUS   &kp STAR  &kp SLASH    &kp N7    &kp N8    &kp N9    &none     &none
                            &trans      &trans    &kp SPACE    &kp N0    &kp RET   &kp COMMA
      >;
    };
```

## Sticky shift

```c
&sk {
  release-after-ms = <250>;
};

/ {
  keymap {
    bindings = <&sk LSHFT>;
  };
};
```
