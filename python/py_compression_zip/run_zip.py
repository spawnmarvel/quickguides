import zipfile as zf
import time


# https://docs.python.org/3/library/zipfile.html

# create instance, zip it and release from memmory since it is a 
# context manager (zip file)
# add compression
# The zipfile module uses various compression attributes such as 
# ZIP_STORED, ZIP_DEFLATED, ZIP_BZIP2, and ZIP_LZMA that dictate how Python compresses the files inside. 
# By default, that attribute is set to ZIP_STORED, meaning no compression.
#compresslevel: None (default for the given compression type) or an integer
#               specifying the level to pass to the compressor.
#               When using ZIP_STORED or ZIP_LZMA this keyword has no effect.
#               When using ZIP_DEFLATED integers 0 through 9 are accepted.
#               When using ZIP_BZIP2 integers 1 through 9 are accepted.

with zf.ZipFile("3_60_mbfile_DE9.zip", mode="w", compression=zf.ZIP_DEFLATED, compresslevel=9) as zfd:
    zfd.write("3_60_mb.jpg")
time.sleep(3)

with zf.ZipFile("3_60_mbfile_BZ9.zip", mode="w", compression=zf.ZIP_BZIP2, compresslevel=9) as zfd:
    zfd.write("3_60_mb.jpg")
time.sleep(3)

with zf.ZipFile("3_60_mbfile_STO.zip", mode="w", compression=zf.ZIP_STORED) as zfd:
    zfd.write("3_60_mb.jpg")
time.sleep(3)

with zf.ZipFile("3_60_mbfile_lZM.zip", mode="w", compression=zf.ZIP_LZMA) as zfd:
    zfd.write("3_60_mb.jpg")




