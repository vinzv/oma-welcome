#!/bin/bash
if rpm -q dnfdrake &>/dev/null; then
	kdialog --title $"OpenMandriva" --msgbox $"DnfDrake is already installed."
else
	enable-repo unsupported
	APP=$"DnfDrake"
    DB=$(kdialog --title $"OpenMandriva" --progressbar $"Installing $APP" 0)
	qdbus $DB org.kde.kdialog.ProgressDialog.showCancelButton false
	pkexec dnf install --assumeyes dnf-utils python-dnf-plugin-versionlock
	mkdir /tmp/dnfdrake-download
	cd /tmp/dnfdrake-download
	sudo dnf download gambas3-gb-dbus gambas3-gb-form gambas3-gb-gtk3 gambas3-gb-gui gambas3-gb-image gambas3-gb-qt5 gambas3-runtime gambas3-gb-form-stock dnfdrake
	sudo rpm -ivh --nodeps *.rpm
	qdbus $DB org.kde.kdialog.ProgressDialog.close
	if rpm -q dnfdrake &>/dev/null; then
		kdialog --title $"OpenMandriva" --msgbox $"Installation succeeded."
	else
		kdialog --title $"OpenMandriva" --msgbox $"Installation failed."
	fi
fi

exit 0
