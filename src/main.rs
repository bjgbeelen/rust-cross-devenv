use std::collections::VecDeque;
use std::io::{Read, Write};
use std::net::{TcpListener, TcpStream};
use std::thread;
use tracing_subscriber::{EnvFilter, FmtSubscriber};

fn main() -> std::io::Result<()> {
    let filter = EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new("info"));
    let subscriber = FmtSubscriber::builder()
        // .with_max_level(tracing::Level::DEBUG)
        .with_env_filter(filter)
        .finish();
    tracing::subscriber::set_global_default(subscriber).expect("setting default subscriber failed");

    let listener = TcpListener::bind("127.0.0.1:9100")?; // Bind to a local port

    tracing::info!("Server listening on 127.0.0.1:9100");

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                tracing::debug!("New client connected!");

                thread::spawn(|| {
                    tracing::debug!("New thread spawned!");
                    let client = reqwest::Client::new();
                    let buffer = [0; 512];
                });
            }
            Err(e) => {
                tracing::error!("Failed to accept client: {}", e);
            }
        }
    }

    Ok(())
}
