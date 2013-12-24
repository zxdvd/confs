import "openqa"
#   you need to set the ISO, virtual disk, needles' location and your hostname
    case $hostname {
        'dell-zxd':   { $sled12_iso='/media/extra/iso/SLED-12A1_64_DVD.iso'
            $sled12_disk='/media/extra/vdisk/sled12alpha1.qcow2'
                $sled12_needles='/media/extra/git/os-autoinst-needles/distri/sled'}
        'hp-zxd'  :   { $sled12_iso='/media/dell-zxd/iso/SLED-12A1_64_DVD.iso'}
        default   :   { fail("unrecognized host, contact Xudong to update") }
    }

include openqa
