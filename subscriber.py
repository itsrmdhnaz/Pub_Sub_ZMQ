import zmq
import sys
import os

def main():
    # Argumen: python subscriber.py <subscriber_id> <topic_id> [host] [port]
    # Contoh : python subscriber.py 103012580030-AMA 103012580030 publisher 9991
    if len(sys.argv) < 3:
        print("Penggunaan: python subscriber.py <ID-Singkatan> <Topic_ID> [host] [port]")
        print("Contoh    : python subscriber.py 103012580030-AMA 103012580030 localhost 9991")
        sys.exit(1)

    subscriber_identity = sys.argv[1]
    topic = sys.argv[2]
    host = sys.argv[3] if len(sys.argv) > 3 else os.environ.get("PUB_HOST", "localhost")
    port = sys.argv[4] if len(sys.argv) > 4 else os.environ.get("PUB_PORT", "9991")

    context = zmq.Context()
    socket = context.socket(zmq.SUB)

    # Hubungkan ke publisher server
    connect_address = f"tcp://{host}:{port}"
    socket.connect(connect_address)

    # Set subscription filter: Hanya mendengarkan topik miliknya sendiri
    socket.setsockopt_string(zmq.SUBSCRIBE, topic)

    print("=" * 65)
    print(f"ZeroMQ Subscriber")
    print(f"Subscriber ID : {subscriber_identity}")
    print(f"Subscribed To : Topic [{topic}]")
    print(f"Connected to  : {connect_address}")
    print("Menunggu pesan dari Publisher...")
    print("=" * 65)

    try:
        while True:
            # Terima pesan
            raw_message = socket.recv_string()

            # Pisahkan topic dan body pesan
            parts = raw_message.split(" ", 1)
            received_topic = parts[0]
            message_body = parts[1] if len(parts) > 1 else ""

            print(f"[{subscriber_identity}] RECV on topic '{received_topic}': {message_body}")

    except KeyboardInterrupt:
        print(f"\n[{subscriber_identity}] Menghentikan subscriber...")
    finally:
        socket.close()
        context.term()

if __name__ == "__main__":
    main()
