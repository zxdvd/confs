# -*- coding: utf-8 -*-

import re, os.path
from subprocess import Popen, PIPE


def getslpsrv():
    """Get service:install.suse:nfs of 147.2.207.1"""

    output = []
    try:
        p = Popen(["slptool", "unicastfindsrvs", "147.2.207.1", "service:install.suse:nfs"], stdout=PIPE)
        for line in p.stdout.readlines():
            output.append(line)
    except Exception as e:
        print("Unexpected error: "+e.message)
    return output

def filter(input, list):
    """ filter the product, only those containing string in the list will be kept."""
    
    output = []
    for line in input:
        if "SLP/" in str(line):
            product = str(line).split('SLP/')[1].split('/')[0]
            for item in list:
                if item in product.lower():
                    output.append(line)
                    break
    return sorted(output)

def topxe(slplist):
    """Convert the slp output to a PXE menu. Generate a pxe.menu file in cwd."""
   
    pattern = re.compile(r'install.suse:((\w+?):.*?dist.install/SLP/((SLE.+?)/.*?)),') 
    with open('pxe.menu', 'w') as f:
        f.write('default menu.c32\n'
                'prompt 0\n'\
                'timeout 300\n'
                'ONTIMEOUT local\n')

        for line in slplist:
            m = pattern.search(str(line))
            if m:
                #print(m.group(1,2,3,4))
                install_url, install_method, path, product = m.group(1,2,3,4)
                #print(product)
                loader_path = os.path.join('images', path, 'boot/x86_64/loader/')
                kernel_path = os.path.join(loader_path, 'linux')
                initrd_path = os.path.join(loader_path, 'initrd')
                #print(kernel_path, initrd_path)
                pxeitem = 'LABEL {0}\n' \
                          '    MENU LABEL {0}\n' \
                          '    KERNEL {1}\n' \
                          '    APPEND initrd={2} install={3}\n'.format(product,\
                                        kernel_path, initrd_path, install_url)
                f.write(pxeitem) 

if __name__ == "__main__":
    slplist = []
    slplist = getslpsrv()
    product = filter(slplist, ['sled', 'server', 'sles', 'desktop'])
    topxe(product)
