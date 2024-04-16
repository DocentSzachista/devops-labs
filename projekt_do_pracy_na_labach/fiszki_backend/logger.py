import logging 

def set_logging():
    # changed logging destination to /log/ subdirectory for
    # easier persistent volume mounting
    handler = logging.FileHandler('log/myapp.log')
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    logger = logging.getLogger(__name__)
    logger.addHandler(handler)
    logger.setLevel(logging.INFO)
    return logger

LOGGER = set_logging()