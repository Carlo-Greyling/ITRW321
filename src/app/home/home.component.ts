import { Component, OnInit } from '@angular/core';
import { JobsModel } from '../shared/jobs.model';
import { Clients } from '../shared/clients.model';
import { Hitmen } from '../shared/hitmen.model';
import {MatTableDataSource} from '@angular/material';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})

export class HomeComponent implements OnInit {
  displayedColumns: string[] = ['Alias', 'Hits', 'Speciality', 'Cost'];
  jobtype;

  hitmen: Hitmen[] = [
    {alias: 'Punisher', hits: 28, speciality: 'Torture', cost: 128.28, region: 'Potchefstroom'},
    {alias: 'Agent 47', hits: 300, speciality: 'Kill', cost: 450.99, region: 'Potchefstroom'},
    {alias: 'Chuck Norris', hits: 145, speciality: 'Blackmail', cost: 200.00, region: 'Cape Town'},
    {alias: 'Agent X', hits: 12, speciality: 'Blackmail', cost: 128.28, region: 'Pretoria'},
    {alias: 'Bob', hits: 206, speciality: 'Torture', cost: 222.15, region: 'Johannesburg'},
  ];

  dataSource = new MatTableDataSource(this.hitmen);

  clients: Clients[] = [
    {clientID: 1, clientFName: 'Ellenor', clientLName: 'Humphreys', clientRegion: 'Potchefstroom'},
    {clientID: 2, clientFName: 'Bogdan', clientLName: 'Chang', clientRegion: 'Johannesburg'},
    {clientID: 3, clientFName: 'Nellie', clientLName: 'Dodd', clientRegion: 'Potchefstroom'},
    {clientID: 4, clientFName: 'Jacque', clientLName: 'Jacobs', clientRegion: 'Johannesburg'},
    {clientID: 5, clientFName: 'Naeem', clientLName: 'Waller', clientRegion: 'Port Elizabeth'},
    {clientID: 6, clientFName: 'Sean', clientLName: 'Haley', clientRegion: 'Pretoria'},
    {clientID: 7, clientFName: 'Martyna', clientLName: 'Villalobos', clientRegion: 'Potchefstroom'},
    {clientID: 8, clientFName: 'Romilly', clientLName: 'Irvine', clientRegion: 'Potchefstroom'},
    {clientID: 10, clientFName: 'Kyle', clientLName: 'Cotton', clientRegion: 'Pretoria'},
    {clientID: 11, clientFName: 'Dwayne', clientLName: 'Ryan', clientRegion: 'Johannesburg'},
    {clientID: 12, clientFName: 'Deon', clientLName: 'Salt', clientRegion: 'Potchefstroom'},
    {clientID: 13, clientFName: 'Lynsey', clientLName: 'Anthony', clientRegion: 'Cape Town'},
    {clientID: 14, clientFName: 'Wren', clientLName: 'Foreman', clientRegion: 'Potchefstroom'},
    {clientID: 15, clientFName: 'Isabel', clientLName: 'Bowler', clientRegion: 'Johannesburg'},
    {clientID: 16, clientFName: 'Kasper', clientLName: 'Berg', clientRegion: 'Cape Town'},
    {clientID: 17, clientFName: 'Ella-Mae', clientLName: 'Conroy', clientRegion: 'Johannesburg'},
    {clientID: 18, clientFName: 'Jackson', clientLName: 'Hardy', clientRegion: 'Potchefstroom'},
    {clientID: 19, clientFName: 'Aydin', clientLName: 'Southern', clientRegion: 'Kimberley'},
    {clientID: 20, clientFName: 'Stella', clientLName: 'Terrell', clientRegion: 'Cape Town'},
    {clientID: 21, clientFName: 'Henri', clientLName: 'van Rensburg', clientRegion: 'Potchefstroom'},
  ];

  jobTypes: JobsModel[] = [
    {value: 'Blackmail-0', viewValue: 'Blackmail'},
    {value: 'Torture-1', viewValue: 'Torture'},
    {value: 'Kill-2', viewValue: 'Kill'},
  ];

  showTable() {
    // document.getElementById('applicableHitmen').style();
  }

  constructor() { }

  ngOnInit() {
  }

  applyFilter(filterValue: string) {
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }
}
