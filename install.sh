# as root, from console
apt-get install ssh

#allow access to /usr/local/lib/R/site-library
usermod -a -G staff iargent


# as root, remote
apt-get -y install r-base git r-cran-rmysql r-cran-rcurl
echo "deb http://www.stats.bris.ac.uk/R/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update
apt-get upgrade


# as normal user, remote
git clone https://github.com/iargent/rserver

cat > ~/.Rprofile <<EOF
## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "http://cran.ma.imperial.ac.uk/" 
       options(repos=r)
})
EOF

R --vanilla <<EOF
install.packages("devtools", "caret", "knitr")
EOF
