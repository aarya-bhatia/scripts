#!/usr/bin/env python3
import humanize
import psutil
import time

def net_usage(interface = "wlp1s0"):
    net_stat = psutil.net_io_counters(pernic=True, nowrap=True)[interface]
    net_in_1 = net_stat.bytes_recv
    net_out_1 = net_stat.bytes_sent
    time.sleep(1)
    net_stat = psutil.net_io_counters(pernic=True, nowrap=True)[interface]
    net_in_2 = net_stat.bytes_recv
    net_out_2 = net_stat.bytes_sent

    net_in = net_in_2 - net_in_1
    net_out = net_out_2 - net_out_1

    sent = humanize.naturalsize(
        net_out, binary=True, gnu=True, format="%0.3f").replace(" ", "")

    received = humanize.naturalsize(
        net_in, binary=True, gnu=True, format="%0.3f").replace(" ", "")

    print(f"IN: {received}/s, OUT: {sent}/s")

net_usage()

# Get network statistics using psutil
# network_stats = psutil.net_io_counters(pernic=True).get(interface)
#
# if network_stats:
#     bytes_sent = network_stats.bytes_sent
#     bytes_received = network_stats.bytes_recv
#
#     # Convert bytes to human-readable format
#     sent = humanize.naturalsize(
#         bytes_sent, binary=True, gnu=True).replace(" ", "")
#
#     received = humanize.naturalsize(
#         bytes_received, binary=True, gnu=True).replace(" ", "")
#
#     print(f"{sent} {received}")
