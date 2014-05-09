class openqa {
    file { '/mnt/puppet':
                ensure  => directory,
    }
    ->
    mount { "/mnt/puppet":
                device  => "147.2.212.117:/puppet",
                fstype  => "nfs",
                ensure  => "mounted",
                options => "defaults",
    }
#   add repo    
    file { "/etc/zypp/repos.d/openqa.repo":
                source  =>  "/mnt/puppet/conf/openqa.repo",
                ensure  =>  present,
    }
#   make sure that packages are installed
    $dep_pkgs = [ "openQA", "os-autoinst", "apache2" ]
    package { $dep_pkgs: 
                ensure  => "installed",
                require => File[ '/etc/zypp/repos.d/openqa.repo' ],
    }
#   use our customised openQA
    file { '/usr/lib/os-autoinst':
                ensure  => 'directory',
                recurse => true,
                source  => '/mnt/puppet/os-autoinst',
                require => Package['os-autoinst'];
           '/usr/share/openqa':
                ensure  => 'directory',
                recurse => true,
                source  => '/mnt/puppet/openqa',
                require => Package['openQA'];
           [ '/var/lib/openqa/pool/1/raid' ]:
                ensure  => 'directory',
                recurse => true,
                owner   => 'geekotest';
    }
    ->
#   all the configure file
    file { 'openqa_conf':
                path   => '/etc/apache2/conf.d/openqa.conf',
                source => '/mnt/puppet/conf/conf.d/openqa.conf',
                ensure => present;
           '/etc/apache2/vhosts.d/openqa.conf':
                source => '/mnt/puppet/conf/vhosts.d/openqa.conf',
                ensure => present;
           '/var/lib/openqa/factory/iso/SLED-12-DVD-x86_64-Media.iso':
                ensure => link,
                target => $sled12_iso;
           ['/var/lib/openqa/pool/1/raid/l1', '/var/lib/openqa/pool/1/raid/l2']:
                ensure => link,
                target => $sled12_disk;
           '/usr/lib/os-autoinst/distri/sled/needles':
                ensure => link,
                target => $sled12_needles;
    }
#   copy the db.sqlite3, only once after the os-autoinst installed,
#   won't overwrite your customer data
    exec { 'copy sqlite3 db':
                command      => "/usr/bin/cp /mnt/puppet/conf/db.sqlite /var/lib/openqa/db/",
                refreshonly  => true,
                subscribe    => Package['openQA'];
    }
#   check the path, if don't contain openqa/tools, add in profile.local
    if  $path !~ /\/usr\/share\/openqa\/tools/ {
        file { '/etc/profile.local':
                source => '/mnt/puppet/conf/profile.local',
                ensure => present,
                require=> File['openqa_conf'];
        }
    }
#   make sure, worker and apache2 service are running
#    service { [ 'apache2', 'openqa-worker@1' ]:
#                ensure => running,
#                enable => true,
#                provider => systemd,
#                subscribe => File['openqa_conf'];
#    }
}

#include openqa
