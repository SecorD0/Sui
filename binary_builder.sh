#!/bin/bash
# Default variables
version=""

# Options
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/colors.sh) --
option_value(){ echo $1 | sed -e 's%^--[^=]*=%%g; s%^-[^=]*=%%g'; }
while test $# -gt 0; do
	case "$1" in
	-h|--help)
		. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
		echo
		echo -e "${C_LGn}Functionality${RES}: The script builds Sui binaries and archives it"
		echo
		echo -e "Usage: script ${C_LGn}[OPTIONS]${RES}"
		echo
		echo -e "${C_LGn}Options${RES}:"
		echo -e "  -v, --version TEXT  the binaries version"
		echo
		echo -e "You can use either \"=\" or \" \" as an option and value ${C_LGn}delimiter${RES}"
		echo
		echo -e "${C_LGn}Useful URLs${RES}:"
		echo -e "https://t.me/OnePackage — noderun and tech community"
		echo
		return 0 2>/dev/null; exit 0
		;;
	-v*|--version*)
		if ! grep -q "=" <<< "$1"; then shift; fi
		version=`option_value "$1"`
		shift
		;;
	*|--)
		break
		;;
	esac
done

# Functions
printf_n(){ printf "$1\n" "${@:2}"; }
main() {
	if [ ! -n "$version" ]; then 
		printf_n "\n${C_R}Specify the version!${RES}\n"
		return 1 2>/dev/null; exit 1
	fi
	if [ ! -d $HOME/sui ]; then
		cd
		git clone https://github.com/MystenLabs/sui
	fi
	cd $HOME/sui
 	git stash
	git pull
	git checkout devnet-$version
	cargo build --release
	rm -rf $HOME/sui_bin/
	mkdir -p $HOME/sui_bin/
	mv $HOME/sui/target/release/{sui,sui-node,sui-faucet,sui-indexer} $HOME/sui_bin/
	cd $HOME/sui_bin/
	tar -czvf "sui-linux-amd64-$version.tar.gz" sui sui-faucet sui-node sui-indexer
	cd
}

# Actions
sudo apt install wget -y &>/dev/null
. <(wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/logo.sh)
main
