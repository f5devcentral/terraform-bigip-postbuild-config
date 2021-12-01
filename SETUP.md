## install Terraform
```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
sudo ln -s ~/.tfenv/bin/* /usr/local/bin
sudo apt install unzip -y
tfenv install 0.15.5
tfenv use 0.15.5
```

## install Ruby
```bash
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo usermod -a -G rvm $USER
```

logout and login

```bash
rvm install ruby
```

## install bundler
```bash
gem install bundler
```

## clone project
```bash
git clone https://github.com/mjmenger/terraform-bigip-postbuild-config.git
```

## install kitchen et al
```bash
bundle install
```