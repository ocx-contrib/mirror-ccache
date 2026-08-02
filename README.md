# mirror-ccache

OCX mirror for [ccache](https://github.com/ccache/ccache). One repository, one
spec directory per package.

| Package | Spec | Publishes to | Announced as | Upstream SPDX |
|---|---|---|---|---|
| [ccache](https://github.com/ccache/ccache) | [`ccache/mirror.yml`](ccache/mirror.yml) | `ghcr.io/ocx-contrib/ccache/ccache` | `ocx.sh/ccache/ccache` | `GPL-3.0-or-later` |

Each upstream release is discovered, re-bundled, smoke-tested per
`(version, platform)` and only then pushed with cascade tags, after which the
result is announced into the OCX index.

> This repository previously published the same upstream to the flat coordinate
> `ocx.sh/ccache`. `ccache/ccache` is the grouped successor — upstream's owner
> org and the tool share the name, so namespace and name coincide.

## Layout

```
mirror-base.yml         repo-wide policy every spec inherits via `extends:`
ccache/
├── mirror.yml          the spec — never at the repo root
├── metadata.json       bundle interface
├── CATALOG.md          → ocx package describe
├── logo.svg / logo.png describe assets, 512px PNG
└── tests/smoke.star    Starlark smoke test
```

`LICENSE` and `NOTICE.md` are shared at the root. Logos are **not** — each
package carries its own, because a repo-root `logo.*` sits in no workflow's
`paths:` filter, so replacing it would publish nothing until some unrelated
edit happened to fire.

⚠️ `extends:` is a **shallow** merge of top-level keys. A spec that restates
`platforms:` to change one runner drops every `containers:` entry with it, and
nothing reds — the legs simply stop existing, and every `os.features` claim
goes back to being asserted rather than verified. Restate a block in full or
not at all.

## Platforms

`ccache` publishes six platform entries: both Linux arches, both macOS arches
and both Windows arches. Upstream ships **two** Linux builds per arch — a
`-musl-static` one and a dynamically linked `-glibc` one — and this mirror
carries only the static pair. `os.features` states what an artifact requires
*of the host*, and the `-musl-static` binaries require nothing: static-pie, no
`PT_INTERP`, no `DT_NEEDED` on either arch. So both Linux keys are **bare** —
tagging them `+libc.musl` would be a false requirement that hid them from every
glibc host, and the `-glibc` twin would add a `libgcc_s.so.1` runtime
dependency for zero extra reach. The `alpine:3.20` container leg in
`mirror-base.yml` is what turns that claim into evidence; the measurement
itself is recorded above the `assets:` block in `ccache/mirror.yml`.

macOS is one **universal** Mach-O per release (`ccache-<v>-darwin.tar.gz`
carries both slices), so both darwin keys resolve to the same asset and the
`darwin/amd64` leg runs under `arch -x86_64` to force the Intel slice.

The version floor is `4.13.1`: `v4.13` is tagged without a patch segment (so
the three-segment tag pattern skips it), and the `-musl-static` asset layout
does not exist below it.

## Editing

| File | Edit | Regenerate after |
|------|------|------------------|
| `mirror-base.yml`, `ccache/mirror.yml` | hand | yes — see below |
| `ccache/{metadata.json,CATALOG.md,logo.*}` | hand | — |
| `ccache/tests/smoke.star` | hand | — |
| `.github/workflows/*.yml` | **generated — never hand-edit** | re-run when a spec changes |

```bash
ocx-mirror package pipeline generate ci --spec ccache/mirror.yml
```

**Name every spec.** `--spec` *appends* rather than replaces, so a command
naming a subset silently stops rendering the rest while staying green — and the
drift guard reds on a generated workflow the current spec set no longer
produces.

`verify-generated.yml` exits 65 on drift. If a generated workflow is wrong, the
spec or the renderer template is wrong — fix it there and regenerate.

Run `direnv allow` once to put the pinned toolchain on `PATH`, and invoke
`ocx-mirror` directly — never `ocx run -- ocx-mirror`, which pins
`OCX_BINARY_PIN` to the bootstrap `ocx` and false-reds the nested push.

## The binaries claim

Upstream's archives wrap everything in `ccache-<version>-<platform>/` with the
executable at that directory's root next to the docs — there is no `bin/`.
`strip_components: 1` peels the wrapper, so the executable *is* the content
root and the bundle's only PATH entry is a bare `${installPath}`. `bin_scan`
only looks *below* an `${installPath}/<dir>` entry, so `auto`/`verify` is
rejected at spec load with exit 65. `mirror-base.yml` therefore sets
`bin_scan: off` and `ccache/metadata.json` hand-lists `binaries: ["ccache"]` —
the blessed shape for this layout.

## Required secrets

| Secret | Use |
|--------|-----|
| `OCX_ANNOUNCE_TOKEN` | opens the index pull request from the `ocx-contrib/index` fork |
| `OCX_MIRROR_DISCORD_HOOK` | notify-stage Discord webhook URL |

(Inherited from the `ocx-contrib` org with visibility ALL. GHCR pushes use the
run's own `GITHUB_TOKEN` — no registry secret needed.)

## License

Apache-2.0 — see [`LICENSE`](LICENSE). Upstream assets are out of scope; each
package's redistribution license is recorded in [`NOTICE.md`](NOTICE.md).
ccache is **GPL-3.0-or-later**, so `NOTICE.md` also carries the per-version
Corresponding Source pointer GPLv3 §6(d) requires.
