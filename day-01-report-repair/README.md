# 01 Report Repair 

My first solution was a straightforward nested for-loop. That works like a 
charm, but then I stumbled upon the [swift-algorithms](https://github.com/apple/swift-algorithms)
repository. 

A perfect opportunity to get some further knowledge of SPM and it results in 
cleaner code; although performance is a bit worse! The forced unwrapping of the
result of `first(where:)` is a bit harsh, but for this (known) input we're safe.

👩‍🔧 🎉 👨‍🔧
