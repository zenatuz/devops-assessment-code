from datetime import datetime
from zoneinfo import ZoneInfo


def timezone(city):
    local_time = datetime.now(ZoneInfo(city))
    return str(local_time)
