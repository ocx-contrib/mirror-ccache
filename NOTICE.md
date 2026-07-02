# NOTICE

This repository packages and redistributes upstream [ccache](https://github.com/ccache/ccache).

The Apache-2.0 license covers the OCX pipeline files authored here, including
`logo.svg` / `logo.png` — an OCX-authored "cc" lettermark used for catalog
identification. ccache has no official project logo; its brand is the
typographic "Ccache" wordmark, and "ccache" remains a name of the upstream
project. It does **not** cover upstream-derived assets — the ccache binaries
published to `ocx.sh/ccache` (GPL-3.0-or-later, the ccache Authors).

## Corresponding Source (GPL-3.0-or-later)

The ccache binaries redistributed here are licensed GPL-3.0-or-later. The
complete Corresponding Source (including build scripts) for every mirrored
version is the upstream tagged tree, offered at the same place as the binaries
under GPLv3 §6(d):

- Version `X.Y.Z` → tag `vX.Y.Z` →
  <https://github.com/ccache/ccache/releases/tag/vX.Y.Z>
- Or clone and check out the exact tag:

  ```bash
  git clone https://github.com/ccache/ccache
  git -C ccache checkout vX.Y.Z   # X.Y.Z = the ocx.sh/ccache version
  ```

No additional restrictions are imposed beyond GPL-3.0-or-later.
