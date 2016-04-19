//
//  Macro.h
//  Pods
//
//  Created by Yooli on 15/4/27.
//
//

#ifndef Macro_h
#define Macro_h

#define macro_concat(A, B) macro_concat_(A, B)
#define macro_concat_(A, B) A ## B

#define macro_ret(N, ...) macro_concat(macro_ret, N)(__VA_ARGS__)

#define macro_ret0(...) macro_retFirst(__VA_ARGS__)
#define macro_ret1(_0, ...) macro_retFirst(__VA_ARGS__)
#define macro_ret2(_0, _1, ...) macro_retFirst(__VA_ARGS__)
#define macro_ret3(_0, _1, _2, ...) macro_retFirst(__VA_ARGS__)
#define macro_ret4(_0, _1, _2, _3, ...) macro_retFirst(__VA_ARGS__)
#define macro_ret5(_0, _1, _2, _3, _4, ...) macro_retFirst(__VA_ARGS__)
#define macro_ret6(_0, _1, _2, _3, _4, _5, ...) macro_retFirst(__VA_ARGS__)

#define macro_retFirst(FIRST, ...) FIRST

#define macro_dec(VAL) macro_ret(VAL, -1, 0, 1, 2, 3, 4, 5)

#define macro_consume_(...)
#define macro_expand_(...) __VA_ARGS__

#define macro_if_eq0_0(...) __VA_ARGS__ macro_consume_
#define macro_if_eq0_1(...) macro_expand_

#define macro_if_eq0(VAL) macro_concat(macro_if_eq0_, VAL)

#define macro_if_eq1(VALUE) macro_if_eq0(metamacro_dec(VALUE))
#define macro_if_eq2(VALUE) macro_if_eq1(metamacro_dec(VALUE))
#define macro_if_eq3(VALUE) macro_if_eq2(metamacro_dec(VALUE))
#define macro_if_eq4(VALUE) macro_if_eq3(metamacro_dec(VALUE))
#define macro_if_eq5(VALUE) macro_if_eq4(metamacro_dec(VALUE))
#define macro_if_eq6(VALUE) macro_if_eq5(metamacro_dec(VALUE))

#define macro_if_eq(A, B)  macro_concat(macro_if_eq, A)(B)

#define macro_argcount(...) macro_ret(6, ##__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)

#define weakify(v) __weak typeof(v) weak_##v = v;
#define strongify(v) __strong typeof(weak_##v) v = weak_##v;
#define blockify(v) (weak_##v)

#endif
