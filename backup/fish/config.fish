if status is-interactive
    # Commands to run in interactive sessions can go here
end

set SPACEFISH_PROMPT_ADD_NEW_LINE false
starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/pvcente/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end