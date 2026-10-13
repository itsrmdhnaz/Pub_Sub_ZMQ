import zmq
import time
import random
import os

# Anggota kelompok yang menjadi subscriber penerima pesan
MEMBERS = [
    {"name": "Alif", "id": "103012580030"},
    {"name": "Brindawan", "id": "103012580016"},
    {"name": "Wisnu", "id": "103012580010"},
]

def main():
    port = os.environ.get("PUB_PORT", "9991")
    games = ["Skyrim", "Elden Ring", "Valorant", "Cyberpunk 2077", "Dota 2"]

    context = zmq.Context()
    socket = context.socket(zmq.PUB)
    socket.bind(f"tcp://*:{port}")

    print("=" * 60)
    print("ZeroMQ Publisher")
    print(f"Listening on   : tcp://*:{port}")
    topics_desc = ", ".join(f"{m['id']}" for m in MEMBERS)
    print(f"Total Topics   : {len(MEMBERS)} ({topics_desc})")
    print("=" * 60)

    time.sleep(1)

    counter = 1
    try:
        while True:
            # Ambil member secara random
            member = random.choice(MEMBERS)
            game = random.choice(games)

            topic = member["id"]
            member_name = member["name"]

            # Template pesan sesuai instruksi tugas:
            # "Hey, I got a new message for ‘Name of your member’ - It is from ‘Your Fav/Random Game’"
            body = f"Hey, I got a new message for '{member_name}' - It is from '{game}'"
            
            # Format pesan ZeroMQ: "<TOPIC> <BODY>"
            message = f"{topic} {body}"

            socket.send_string(message)
            print(f"[PUBLISHER #{counter}] Sent to Topic [{topic}] ({member_name}): {body}")

            counter += 1
            time.sleep(2)  # Kirim setiap 2 detik

    except KeyboardInterrupt:
        print("\n[PUBLISHER] Menghentikan publisher...")
    finally:
        socket.close()
        context.term()

if __name__ == "__main__":
    main()
