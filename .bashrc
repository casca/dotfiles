if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]'
	PS1="$PS1"'\n'
	CHECK_MARK="\[\e[1;32m\]\342\234\223"
	UNCHECK_MARK="\[\e[1;31m\]\342\234\227"
	if [ "$PS1" != "" ]
	then
		PS1="\$(if [[ \$? == 0 ]]; then echo '$CHECK_MARK '; else echo '$UNCHECK_MARK '; fi)"
	fi	
	PS1="$PS1"'\[\033[32m\]\A '
	PS1="$PS1"'\[\033[31m\]\W'
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[34m\]'
			PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	PS1="$PS1"'\[\033[0m\]'        # change color
	export PS1="$PS1"' \$ '
fi

export MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
