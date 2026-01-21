#ifndef LENSERESULTS_H
#define LENSERESULTS_H

#include <QObject>
#include "src/qevercloud/include/qevercloud/QEverCloud.h"
using namespace qevercloud;

class LenseResults : public QObject
{
    Q_OBJECT
public:
    explicit LenseResults(QObject *parent = 0);
    Note note;

signals:

public slots:

};

#endif // LENSERESULTS_H
