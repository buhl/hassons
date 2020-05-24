#!/usr/bin/with-contenv bashio
bashio::log.info "Configuring radicale"
declare port
port=$(bashio::addon.port 5232)
encryption_method=$(bashio::config "encryption_method" "md5")
log_level=$(bashio::config "log_level" "warning")
rights_type=$(bashio::config "rights_type" "owner_only")

if ! bashio::var.has_value "${port}"; then
    bashio::log.fatal
    bashio::log.fatal "No port configured"
    bashio::log.fatal
    bashio::exit.nok
fi

if bashio::config.equals "rights_type" "from_file"; then
    if ! bashio::config.has_value "rights_file"; then
        bashio::log.fatal
        bashio::log.fatal "rights.file must be configured when rights.type is set to from_file"
        bashio::log.fatal
        bashio::exit.nok
        exit 1;
    fi
    sed -i "s/^#FROM_FILE\(.*\)$/\1/g" /etc/radicale/config
    bashio::log.info "adding right rules"
    echo -n "" > /etc/radicale/rights
    for n in $(bashio::config "rights_file|keys"); do
        bashio::log.info "adding right_rule ${n}"
        SECTION=$(bashio::config "rights_file[${n}].section")
        USER=$(bashio::config "rights_file[${n}].user")
        COLLECTION=$(bashio::config "rights_file[${n}].collection")
        PERMISSIONS=$(bashio::config "rights_file[${n}].permissions")
        echo "[${SECTION}]" >> /etc/radicale/rights
        echo "user = ${USER}" >> /etc/radicale/rights
        echo "collection = ${COLLECTION}" >> /etc/radicale/rights
        echo "permissions = ${PERMISSIONS}" >> /etc/radicale/rights
        echo "" >> /etc/radicale/rights
    done
    bashio::log.info "right rules added"
fi

sed -i "s/%PORT%/${port}/g" /etc/radicale/config
sed -i "s/%ENCRYPTION_METHOD%/${encryption_method}/g" /etc/radicale/config
sed -i "s/%LOG_LEVEL%/${log_level}/g" /etc/radicale/config
sed -i "s/%RIGHTS_TYPE%/${rights_type}/g" /etc/radicale/config

echo -n "" > /etc/radicale/users
for n in $(bashio::config "credentials|keys"); do
    USERNAME=$(bashio::config "credentials[${n}].username")
    PASSWORD=$(bashio::config "credentials[${n}].password")
    echo "${USERNAME}:${PASSWORD}" >> /etc/radicale/users
done
bashio::log.info "Configuration of radicale complete"
