#include "ILASManager.h"
#include "QGCApplication.h"

#include <QDebug>
#include <QDir>

ILASManager::ILASManager(QObject *parent)
    : QObject(parent)
    , m_process(new QProcess(this))
{
    connect(m_process, &QProcess::finished, this, &ILASManager::onProcessFinished);
    connect(m_process, &QProcess::errorOccurred, this, &ILASManager::onProcessError);
    connect(m_process, &QProcess::readyReadStandardOutput, this, &ILASManager::onReadyReadStandardOutput);
    connect(m_process, &QProcess::readyReadStandardError, this, &ILASManager::onReadyReadStandardError);
}

ILASManager::~ILASManager()
{
    stop();
}

void ILASManager::start()
{
    if (m_process->state() == QProcess::Running) {
        qWarning() << "ILAS process is already running.";
        return;
    }

    QString program = "python3";
    QStringList arguments;
    arguments << "-u" << QDir(qgcApp()->applicationDirPath()).filePath("../external/ILAS/main.py");
    arguments << "--connection_string" << "udp:127.0.0.1:14555";

    qInfo() << "Starting ILAS process:" << program << arguments;

    m_process->start(program, arguments);

    if (!m_process->waitForStarted()) {
        emit ilasError("Failed to start ILAS process.");
        return;
    }

    emit ilasStarted();
}

void ILASManager::stop()
{
    if (m_process->state() == QProcess::NotRunning) {
        return;
    }

    m_process->terminate();
    if (!m_process->waitForFinished(5000)) {
        m_process->kill();
    }
}

void ILASManager::onProcessFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    qInfo() << "ILAS process finished with exit code" << exitCode << "and status" << exitStatus;
    emit ilasStopped();
}

void ILASManager::onProcessError(QProcess::ProcessError error)
{
    qWarning() << "ILAS process error:" << error;
    emit ilasError(m_process->errorString());
}

void ILASManager::onReadyReadStandardOutput()
{
    emit ilasOutput(m_process->readAllStandardOutput());
}

void ILASManager::onReadyReadStandardError()
{
    emit ilasError(m_process->readAllStandardError());
}
