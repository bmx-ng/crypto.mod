# Crypto.Blake3Digest

BLAKE3 for BlitzMax-NG, using the official BLAKE3 1.8.7 implementation.

```blitzmax
SuperStrict
Framework BRL.StandardIO
Import Crypto.Blake3Digest

Local digest:TMessageDigest = GetMessageDigest("BLAKE3")
Print digest.Digest("abc")
```

The result is `6437b3ac38465133ffb63b75273a8db548c558465d79db03fd359c6cd5bd9d85`.

## API

- `New TBlake3Digest`: ordinary hashing; `OutBytes()` returns 32.
- `TBlake3Digest.CreateKeyed(key)`: keyed hashing with exactly 32 key bytes.
- `TBlake3Digest.CreateDeriveKey(context)`: key derivation with a hardcoded,
  globally unique, application-specific UTF-8 context. Feed high-entropy key
  material using `Update`. This is not a password hashing function.
- `Update(pointer, count)` / `Update(bytes)`: incremental input, returning zero.
  The pointer overload uses the existing `TMessageDigest` signed `Int` count;
  larger inputs can be supplied in successive calls or through a stream.
- `Finish(bytes)`: writes exactly 32 bytes, then resets the message. Larger
  destinations retain their trailing bytes; shorter ones throw in both debug
  and release builds, without consuming the state.
- `FinishXOF(bytes)`: fills the entire array, then resets the message. An empty
  array still resets the message.
- `Output(bytes, seek = 0:ULong)`: reads extended output without changing the
  state. `seek` is a byte position, not a block number or mutable cursor. Updates
  can continue afterward. Output ranges must not wrap the 64-bit position.
- `Reset()`: discards the message while retaining the mode and key.
- Inherited `Digest`/overridden `DigestBytes`: consume a String or TStream and
  finish. Like the existing digest API, these include any prior `Update` calls.
  Strings use their complete UTF-8 encoding, including embedded NULs. Streams
  are read in 64 KiB chunks until a zero read; read errors clear the partial
  state and propagate. The caller retains ownership of the stream.

The registry accepts `BLAKE3`, `BLAKE3-256`, `BLAKE3_256`, and `BLAKE3256`, ignoring
case; `ListDigests` lists the canonical `BLAKE3` name.

Instances must not be concurrently mutated. Raw pointers must address enough
readable memory. Native state is wiped before it is freed, but caller-owned keys,
input buffers and copies made by the runtime remain the caller's responsibility.

## Targets and implementation

The module does not require OS APIs, dynamic libraries, Rust, oneTBB or worker
threads. It uses one native allocation per instance (1,912 bytes on tested x64
builds), in addition to the BlitzMax object. Updating, finishing into a supplied
array, reading output and resetting do not allocate in the binding. String
conversion and convenience methods returning arrays necessarily allocate.

Backend selection follows architecture and compiler capabilities:

| Target architecture | Default backend |
| --- | --- |
| Windows x64 | Upstream GNU assembly with runtime SSE2/SSE4.1/AVX2/AVX-512 selection |
| Other x64 and x86 | Upstream SIMD C, with GCC/Clang target attributes per translation unit and runtime CPU selection |
| Little-endian AArch64, including Android arm64v8a | Upstream NEON C selected by upstream CPU/endian detection |
| Other CPUs, including ARM32, RISC-V, PPC and Emscripten | Portable C |

These paths apply to BlitzMax targets beyond desktop Windows/Linux/macOS,
including Android, iOS, Raspberry Pi, Haiku and NX. Actual availability also
depends on the compiler/runtime and `Crypto.Digest` dependencies supporting that
target. **Verified here: Windows x64 and Linux x64.** Other targets have not been
compiled or run in this development environment. No universal qualification is
claimed. The C implementation currently has no WASM SIMD backend.

The SIMD C wrappers keep ISA flags local; the dispatcher and portable code are
compiled for the baseline CPU. BMK invokes native assemblers without C
preprocessing, so upstream's preprocessed Unix assembly is not imported.

`-ud blake3_portable` disables all SIMD for testing or a smaller build. Changing
user definitions requires rebuilding the module: `makeapp -a` alone does not
force all imported modules to rebuild. Use separate installations/build trees,
or explicitly run the appropriate `makemods -a` command below.

## Tests and benchmark

From the BlitzMax installation root (use `bin/bmk.exe` on Windows):

```text
bin/bmk makemods -a -r crypto.blake3digest
bin/bmk makeapp -a -r -t console -o blake3-tests mod/crypto.mod/blake3digest.mod/tests/test_blake3.bmx
bin/bmk makemods -a -d crypto.blake3digest
bin/bmk makeapp -a -d -t console -o blake3-tests-debug mod/crypto.mod/blake3digest.mod/tests/test_blake3.bmx
```

Run the generated executables. For portable validation, add
`-ud blake3_portable` to **both** commands for each configuration. Rebuild the
default module afterward if reusing the same installation.

The suite contains all 35 official vectors in all three modes, 131-byte output,
seeked output, nine input chunk sizes around block/tree boundaries, mode-preserving
resets, registry lookup, UTF-8/NUL input, stream input, invalid arguments, output
tail preservation and stream failures. Checks use executable conditions rather
than debug-only assertions. Each run performs 724,739 checks.

`tests/benchmark.bmx` compares the binding with direct upstream C hashing of the
same bytes. It uses a reused hot input buffer, one thread, 512 MiB per sample,
three samples per chunk size and reports the best time. This measures hashing,
not disk I/O or end-to-end application performance. Returned hashes are compared.

## Provenance

Upstream: <https://github.com/BLAKE3-team/BLAKE3>

Tag `1.8.7`, commit `f3149ec5bb5449af877ba20377a11008ff499fa2`.
The selected files under `blake3/` and `tests/test_vectors.json` are copied
unchanged. `tests/vectors.bmx` is generated from that JSON with
`python3 tests/generate_vectors.py`.

The binding is licensed under 0BSD. Upstream BLAKE3 retains its original license
choices, included in `blake3/LICENSE_*`.
