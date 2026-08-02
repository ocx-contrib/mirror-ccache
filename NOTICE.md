# NOTICE

This repository packages and redistributes upstream software published by the
[ccache project](https://github.com/ccache/ccache). The Apache-2.0 license in
[`LICENSE`](LICENSE) covers the OCX pipeline files authored here. It does
**not** cover any upstream-derived asset — each package's redistributed bytes
carry their own license, recorded below.

Each package's logo is reproduced for catalog identification only, under
nominative fair use. The marks remain the property of their respective owners
and no endorsement is implied.

| Package | GHCR path | Upstream SPDX |
|---|---|---|
| `ccache` | `ghcr.io/ocx-contrib/ccache/ccache` | `GPL-3.0-or-later` |

---

## `ccache`

Upstream: <https://github.com/ccache/ccache>
Published to `ghcr.io/ocx-contrib/ccache/ccache`.

| Component | SPDX | Holder |
|---|---|---|
| ccache (`ccache`) | **GPL-3.0-or-later** | Copyright the ccache Authors — see upstream [`doc/authors.adoc`](https://github.com/ccache/ccache/blob/master/doc/authors.adoc) and <https://ccache.dev/credits.html> |

Copyleft. The id is read off upstream's own
[`LICENSE.adoc`](https://github.com/ccache/ccache/blob/master/LICENSE.adoc) —
"either version 3 of the License, or (at your option) any later version" —
because GitHub's licence API answers `NOASSERTION` for this repository. Every
redistributed archive ships upstream's `GPL-3.0.txt`, `LICENSE.md` and
`AUTHORS.md` alongside the executable, and those files are carried into the OCX
bundle unmodified.

### Corresponding Source (GPL-3.0-or-later)

The complete Corresponding Source (including build scripts) for every mirrored
version is the upstream tagged tree, offered at the same place as the binaries
under GPLv3 §6(d):

- Version `X.Y.Z` → tag `vX.Y.Z` →
  <https://github.com/ccache/ccache/releases/tag/vX.Y.Z>
  (each release additionally attaches the source tarballs
  `ccache-X.Y.Z.tar.gz` / `ccache-X.Y.Z.tar.xz`)
- Or clone and check out the exact tag:

  ```bash
  git clone https://github.com/ccache/ccache
  git -C ccache checkout vX.Y.Z   # X.Y.Z = the ocx.sh/ccache/ccache version
  ```

No additional restrictions are imposed beyond GPL-3.0-or-later.

The ccache name is used for catalog identification under nominative fair use.
ccache has no official project logo — its brand is the typographic "Ccache"
wordmark — so the logo shipped with this package is an OCX-authored "cc"
lettermark, Apache-2.0 like the rest of the pipeline files, not an official
ccache mark.

No modifications are made to any upstream artifact in this repository; they are
republished byte-for-byte inside an OCX bundle.
