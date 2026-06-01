---
title: ccache
description: A fast C/C++ compiler cache that speeds up recompilation by caching previous compilations
keywords: ccache,compiler-cache,c,cpp,build,caching,gcc,clang
---

# ccache

ccache is a compiler cache. It speeds up recompilation by caching the result of
previous compilations and detecting when the same compilation is being done
again. It supports C, C++, and other languages compiled via GCC or Clang, works
on Linux, macOS, and Windows, and can share its cache across machines via local,
HTTP, and Redis remote-storage backends.

## What's included

- **ccache** — the compiler cache CLI; wrap your compiler invocation
  (`ccache gcc -c foo.c`) and inspect/configure the cache with `-s`, `-p`,
  `--set-config`, and friends.

## Links

- [ccache Documentation](https://ccache.dev/documentation.html)
- [ccache on GitHub](https://github.com/ccache/ccache)
