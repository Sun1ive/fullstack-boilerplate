import { SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import { NestGateway } from '@nestjs/websockets/interfaces/nest-gateway.interface';
import { Server, Socket } from 'socket.io';

@WebSocketGateway()
export class SocketGateway implements NestGateway {
  @WebSocketServer()
  private server: Server;

  @SubscribeMessage('message')
  public handleMessage(client: SocketIO.Client, payload: any): void {
    console.log(client.id);

    this.server.emit('pong', { pong: 'ping' });
  }

  handleConnection(socket: Socket) {
    console.log('Client connected %s', socket.id);

    socket.emit('hello', { data: 'world' });
  }

  afterInit() {
    console.log('INIT GATEWAY');
  }

  handleDisconnect() {
    console.log('Client disconnected');
  }
}
