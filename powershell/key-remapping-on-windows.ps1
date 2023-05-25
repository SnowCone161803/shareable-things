# WARNING: this modifies the windows registry.
# I make no guarantees that it works or won't damage your computer.
# Licence MIT (see LICENCE)
#
# Explanation of how it works can be found here: 
# http://www.howtogeek.com/howto/windows-vista/disable-caps-lock-key-in-windows-vista/
#
# tested on Windows 10

$registryPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
$name = "Scancode Map"

[byte[]]$prefix = 0,0,0,0,0,0,0,0
[byte[]]$dataLength = 2,0,0,0
[byte[]]$keyTeminator = 0,0,0,0

# Some mappings; there are loads more here:
# https://msdn.microsoft.com/en-us/library/aa299374%28v=vs.60%29.aspx?f=255&MSPPError=-2147217396
[byte[]]$noKey = 0,0
[byte[]]$capsLock = 0x3a,0
[byte[]]$f7 = 0x41,0
[byte[]]$f8 = 0x42,0
[byte[]]$f9 = 0x43,0
[byte[]]$backspace = 0x0e,0

function buildMapping([byte[]]$from, [byte[]]$to) {
    return $prefix + $dataLength + $to + $from + $keyTeminator
}

# TODO: choose the mapping you want to make here and run the script
[byte[]]$mapping = buildMapping -from $capsLock -to $f8
New-ItemProperty -Force -Name $name -PropertyType Binary -Path $registryPath -Value $mapping
