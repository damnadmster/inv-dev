SpecialLog.logger = Logger.new(SpecialLog::LogFile)
SpecialLog.logger.level = 'debug' # could be debug, info, warn, error or fatal
SpecialLog.logger.datetime_format = "%Y-%m-%d %H:%M:%S"