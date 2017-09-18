# waveland-autosplitter
A short autosplitter for the Waveland demo (https://rologfos.com/demo)

Splits (each one can be toggled):
- Enter 1-1
- Enter any level except 1-1 (default off)
- Finish a level
- Enter final cutscene

To use it, download the .asl file, create a "Scriptable Auto Splitter" component in the Edit Layout menu, and point it towards the file.

Currently, it only works with the demo, and cannot auto-start the run (the option does nothing), so you still need to do that yourself.

Also, note that it will create a split when you complete a level even if that level is already complete. This could create a problem if you get a D (any%) or less than an S (100%) and have to restart, but at that point you'll probably just discard the run anyway.
