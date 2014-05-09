import "openqa"
#   you need to set the ISO, virtual disk, needles' location and your hostname
    case $hostname {
        'dell-zxd':   { $sled12_iso='/media/extra/iso/SLED-12A1_64_DVD.iso'
                        $sled12_disk='/media/extra/vdisk/sled12alpha2.qcow2'
                        $sled12_needles='/media/extra/git/os-autoinst-needles-sles'}
        'hp-zxd'  :   { $sled12_iso='/media/dell-zxd/iso/SLED12-DVD-x86_64-Alpha2.iso'
                        $sled12_disk='/media/extra/vdisk/sled12alpha2.qcow2'
                        $sled12_needles='/media/extra/git/os-autoinst-needles-sles'}
        default   :   { fail("unrecognized host, contact Xudong to update") }
    }

include openqa
