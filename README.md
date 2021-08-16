# CANSifter
Sifts two different blf logs to find the differing CAN signals or messages between them. Currently only works with one channel at a time.

The requirements for the script to work are:
  -One DBC file
  -Two different .blf files that you would like to compare
  -The correct channel of the CAN network you are trying to read

Things to do about this:
  -currently the output signals and messsages do not spefiy which log they are missing from
  -Add UI at somepoint?
  -Add a function to sift through to find signals that have differing values at a specified period 
  of time. This would greatly help with vehicle debugging. Make sure to exclude Checksums
  and protection values in most cases
