#
# keepalived module
# 2013/08/27 @SatchanP
#
class keepalived_vip {

    define real_server($lvs_ip="") {
        $filename = regsubst($name, ':', '')
        file { "/etc/network/if-pre-up.d/${filename}":
            mode    => 755,
            owner   => "root",
            group   => "root",
            content => template("keepalived/etc/network/if-pre-up.d/ifcfg-lvs"),
            notify  => Exec["${filename}"],
        }
        exec { "${filename}":
            command => "/bin/bash /etc/network/if-pre-up.d/${filename}",
        }
    }
}
~                           
