def tarai(x, y, z) =
    x <= y ? y : tarai(tarai(x-1, y, z),
                       tarai(y-1, z, x),
                       tarai(z-1, x, y))
require 'benchmark'
Benchmark.bm { |x|
    # sequential version
    x.report('seq'){ 4.times{ tarai(14, 7, 0) } }

    # parallel version with ractors
    x.report('par'){
      4.times.map { |x|
        Ractor.new { tarai(14, 7, 0) }
      }.each(&:take)
    }
}