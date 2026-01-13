
#ifndef QEVERCLOUD_EXPORT_H
#define QEVERCLOUD_EXPORT_H

#ifdef BUILDING_QEVERCLOUD_STATIC_LIBRARY
#  define QEVERCLOUD_EXPORT
#  define QEVERCLOUD_NO_EXPORT
#else
#  ifndef QEVERCLOUD_EXPORT
#    ifdef qt5qevercloud_EXPORTS
        /* We are building this library */
#      define QEVERCLOUD_EXPORT __attribute__((visibility("default")))
#    else
        /* We are using this library */
#      define QEVERCLOUD_EXPORT __attribute__((visibility("default")))
#    endif
#  endif

#  ifndef QEVERCLOUD_NO_EXPORT
#    define QEVERCLOUD_NO_EXPORT __attribute__((visibility("hidden")))
#  endif
#endif

#ifndef QEVERCLOUD_DEPRECATED
#  define QEVERCLOUD_DEPRECATED __attribute__ ((__deprecated__))
#endif

#ifndef QEVERCLOUD_DEPRECATED_EXPORT
#  define QEVERCLOUD_DEPRECATED_EXPORT QEVERCLOUD_EXPORT QEVERCLOUD_DEPRECATED
#endif

#ifndef QEVERCLOUD_DEPRECATED_NO_EXPORT
#  define QEVERCLOUD_DEPRECATED_NO_EXPORT QEVERCLOUD_NO_EXPORT QEVERCLOUD_DEPRECATED
#endif

#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef QEVERCLOUD_NO_DEPRECATED
#    define QEVERCLOUD_NO_DEPRECATED
#  endif
#endif

#endif /* QEVERCLOUD_EXPORT_H */
