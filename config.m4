dnl $Id$
dnl config.m4 for extension runkit

PHP_ARG_ENABLE(runkit, whether to enable runkit support,
[  --enable-runkit           Enable runkit support], no, yes)

PHP_ARG_ENABLE(runkit-modify, whether to enable runtime manipulation of functions/classes/constants,
[  --enable-runkit-modify    Enable runtime manipulation], inherit, no)

PHP_ARG_ENABLE(runkit-super, whether to enable registration of user-defined autoglobals,
[  --enable-runkit-super     Enable registration of user-defined autoglobals], inherit, no)

if test "$PHP_RUNKIT" != "no"; then
  if test "$PHP_RUNKIT_MODIFY" = "inherit"; then
    PHP_RUNKIT_MODIFY=yes
  fi
  if test "$PHP_RUNKIT_SUPER" = "inherit"; then
    PHP_RUNKIT_SUPER=yes
  fi
else
  if test "$PHP_RUNKIT_MODIFY" = "inherit"; then
    PHP_RUNKIT_MODIFY=no
  fi
  if test "$PHP_RUNKIT_SUPER" = "inherit"; then
    PHP_RUNKIT_SUPER=no
  fi
fi

if test "$PHP_RUNKIT_MODIFY" = "yes" ||
   test "$PHP_RUNKIT_SUPER" = "yes"; then
  if test "$PHP_RUNKIT" != "classkit"; then
    PHP_RUNKIT=yes
  fi
fi

if test "$PHP_RUNKIT" != "no"; then
  if test "$PHP_RUNKIT" = "classkit"; then
    AC_DEFINE(PHP_RUNKIT_CLASSKIT_COMPAT, 1, [Whether to export classkit compatible function aliases])
  fi
  if test "$PHP_RUNKIT_MODIFY" != "no"; then
    AC_DEFINE(PHP_RUNKIT_FEATURE_MODIFY, 1, [Whether to export runtime modification features])
  fi
  if test "$PHP_RUNKIT_SUPER" != "no"; then
    AC_DEFINE(PHP_RUNKIT_FEATURE_SUPER, 1, [Whether to export custom autoglobal registration feature])
  fi
  PHP_NEW_EXTENSION(runkit, runkit.c runkit_functions.c runkit_methods.c \
runkit_constants.c \
runkit_object_id.c \
runkit_common.c \
runkit_zend_execute_API.c \
, $ext_shared,, -Wdeclaration-after-statement -Werror -Wall -Wno-deprecated-declarations -Wno-pedantic)
fi
