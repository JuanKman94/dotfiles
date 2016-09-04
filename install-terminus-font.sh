PREV_DIR = `pwd`
cd /tmp

wget http://downloads.sourceforge.net/project/terminus-font/terminus-font-4.40/terminus-font-4.40.tar.gz
tar zxvf terminus-font-4.40.tar.gz
cd terminus-font-4.40

./configure --prefix=/usr
make pcf

sudo make install-pcf
sudo make fontdir
make clean

cd $PREV_DIR
rm -r /tmp/terminus-font-4.40
