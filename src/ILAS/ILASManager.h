#pragma once

#include <QObject>
#include <QProcess>

class ILASManager : public QObject
{
    Q_OBJECT
public:
    explicit ILASManager(QObject *parent = nullptr);
    ~ILASManager();

    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();

signals:
    void ilasStarted();
    void ilasStopped();
    void ilasError(const QString &error);
    void ilasOutput(const QString &output);

private slots:
    void onProcessFinished(int exitCode, QProcess::ExitStatus exitStatus);
    void onProcessError(QProcess::ProcessError error);
    void onReadyReadStandardOutput();
    void onReadyReadStandardError();

private:
    QProcess *m_process;
};
