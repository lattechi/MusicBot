FROM python:3.9-bullseye

# Add project source
WORKDIR /musicbot
COPY . ./
COPY ./config sample_config

# Install dependencies
RUN apt-get update && apt-get install \
ffmpeg \
libffi-dev \
libnacl-dev \
python-dev -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Install pip dependencies
RUN pip3 install --no-cache-dir yt-dlp pynacl 'discord.py[voice]==1.7.3'

# Create volumes for audio cache, config, data and logs
# VOLUME ["/musicbot/audio_cache", "/musicbot/config", "/musicbot/data", "/musicbot/logs"]

# ENV APP_ENV=docker

# ENTRYPOINT ["/bin/sh", "docker-entrypoint.sh"]

CMD python main.py
