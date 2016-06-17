#ifndef _PAGE_H_
#define _PAGE_H_ 1
#include <QWebEnginePage>

class Page:public QWebEnginePage {
	Q_OBJECT
public:
	Page(QObject *parent=0):QWebEnginePage(parent) {}
	void open(QString file);
protected:
	bool acceptNavigationRequest(QUrl const &url, NavigationType type, bool isMainFrame) override;
};
#endif
