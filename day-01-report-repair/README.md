# day-01 Report Repair 

My first solution was a straightforward nested for-loop. Works like a charm, but
I stumbled upon the [swift-algorithms](https://github.com/apple/swift-algorithms)
repository. 

Perfect opportunity to get some further knowledge of SPM and results in cleaner
code; although performance is a bit worse! The forced unwrapping of the result 
of `first(where:)` is a bit harsh, but for this (known) input we're safe.

👩‍🔧 🎉 👨‍🔧
