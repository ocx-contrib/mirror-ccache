# Stable smoke test — assert on the contract (exit code, version shape, file
# side effects), never on help/version prose. ccache reworks its banner and
# feature line freely; the version digits and CCACHE_DIR behavior are the
# contract.
CCACHE = "ccache.exe" if ocx.target_platform.os == ocx.os.Windows else "ccache"

# Tier 1 + 2: liveness + version SHAPE (not the vendor string, not the exact version).
r_version = ocx.run(CCACHE, "--version")
expect.ok(r_version)
expect.matches(r_version.stdout, r"\d+\.\d+\.\d+")

# Tier 3: functional behavior on hermetic input. `-s` prints the stats summary
# with the cache directory pointed at scratch; assert exit 0 (the real code path
# runs), not any prose.
ocx.mkdir("cache")
cache = ocx.scratch_root + "/cache"
r_stats = ocx.run(CCACHE, "-s", env={"CCACHE_DIR": cache})
expect.ok(r_stats)

# Tier 4: env-var wiring — prove the executable honors CCACHE_DIR. Writing a
# config setting materializes ccache.conf under the directory the env var
# points at; assert the side effect lands in scratch.
r_set = ocx.run(CCACHE, "--set-config", "max_size=1G", env={"CCACHE_DIR": cache})
expect.ok(r_set)
expect.true(ocx.exists("cache/ccache.conf"))
