export class Clients {
  public clientID: number;
  public clientFName: string;
  public clientLName: string;
  public clientRegion: string;

  constructor(clientID: number, clientFName: string, clientLName: string, clientRegion: string) {
    this.clientID = clientID;
    this.clientFName = clientFName;
    this.clientLName = clientLName;
    this.clientRegion = clientRegion;
  }
}
