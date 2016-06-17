#include "Page.h"
#include <QProcess>
using namespace std;

bool Page::acceptNavigationRequest(QUrl const &url, NavigationType type, bool isMainFrame) {
	if(url.isLocalFile()) {
		open(url.path());
		return false;
	}
	return true;
}

void Page::open(QString file) {
	if(!file.contains("://") && !file.startsWith("/"))
		file="/usr/share/oma-welcome/" + file;

	if(file.startsWith('/') && (file.endsWith(".sh.htm") || file.endsWith(".sh.html"))) {
		QProcess p(this);
		p.setWorkingDirectory(file.section('/', 0, -2));
		p.start("/bin/bash", QStringList() << "-c" << file, QProcess::ReadOnly);
		p.waitForFinished(60000);
		setContent(p.readAllStandardOutput().replace("target=\"hidden\" ", ""), "text/html", QUrl("file://" + file));
	} else if(file.endsWith(".run")) {
		QProcess::startDetached("/bin/bash", QStringList() << "-c" << file);
	} else
		QWebEnginePage::load(file);
}
