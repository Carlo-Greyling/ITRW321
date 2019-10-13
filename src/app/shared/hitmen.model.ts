export class Hitmen {
  public alias: string;
  public hits: number;
  public speciality: string;
  public cost: any;
  public region: string;

  constructor(alias: string, hits: number, speciality: string, cost: any, region: string) {
  this.alias = alias;
  this.hits = hits;
  this.speciality = speciality;
  this.cost = cost;
  this.region = region;
  }
}
