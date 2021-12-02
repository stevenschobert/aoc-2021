FROM gitpod/workspace-full

USER gitpod
RUN sudo add-apt-repository ppa:haxe/releases -y && \
    sudo apt-get update && \
    sudo apt-get install haxe -y && \
    mkdir ~/haxelib && haxelib setup ~/haxelib