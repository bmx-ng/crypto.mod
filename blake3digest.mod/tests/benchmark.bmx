SuperStrict
Framework BRL.StandardIO
Import Crypto.Blake3Digest
Import "benchmark.c"

Extern "C"
	Function bmx_blake3_benchmark_time:Double()
	Function bmx_blake3_benchmark_state_size:Size_T()
	Function bmx_blake3_benchmark_native(data:Byte Ptr, size:Size_T, count:Int, output:Byte Ptr)
End Extern

Print "Native state bytes: " + bmx_blake3_benchmark_state_size()
Print "Hot-buffer, single-thread throughput; best of 3; 512 MiB per sample."
For Local chunk:Int = EachIn [64, 1024, 65536, 1048576]
	Local data:Byte[chunk]
	For Local i:Int = 0 Until chunk
		data[i] = i Mod 251
	Next
	Local count:Int = 512 * 1024 * 1024 / chunk
	Local digest:TBlake3Digest = New TBlake3Digest
	Local output:Byte[32]
	Local nativeOutput:Byte[32]
	Local bestNative:Double = 1.0e10
	Local bestBinding:Double = 1.0e10
	' Warm the code and dispatcher before timing.
	digest.Update(data)
	digest.Finish(output)
	For Local trial:Int = 0 Until 3
		Local started:Double = bmx_blake3_benchmark_time()
		bmx_blake3_benchmark_native(data, Size_T(chunk), count, nativeOutput)
		Local elapsed:Double = bmx_blake3_benchmark_time() - started
		bestNative = Min(bestNative, elapsed)
		started = bmx_blake3_benchmark_time()
		For Local i:Int = 0 Until count
			digest.Update(data, chunk)
		Next
		digest.Finish(output)
		elapsed = bmx_blake3_benchmark_time() - started
		bestBinding = Min(bestBinding, elapsed)
		If BytesToHex(output) <> BytesToHex(nativeOutput) Then RuntimeError "Benchmark digest mismatch."
	Next
	Print "chunk=" + chunk + " native_MiB_s=" + (512.0 / bestNative) + " binding_MiB_s=" + (512.0 / bestBinding)
Next
