FROM ros:noetic

WORKDIR /home
ENV HOME=/home

RUN sudo apt-get -y update && sudo apt-get -y install git

RUN sudo apt-get -y install vim ranger

# fixes prompts during apt installations
RUN echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
RUN sudo apt-get install -y -q

RUN mkdir ~/git && cd ~/git && git clone https://github.com/ctu-mrs/mrs_uav_system

RUN cd ~/git/mrs_uav_system && ./install.sh

CMD ["bash"]
