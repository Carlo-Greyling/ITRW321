import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {MatButtonModule} from '@angular/material/button';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { StatScreenComponent } from './stat-screen/stat-screen.component';
import { HomeComponent } from './home/home.component';
import {MatFormFieldModule, MatInputModule, MatListModule, MatSelectModule, MatTableModule} from '@angular/material';
import {FormsModule} from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    StatScreenComponent,
    HomeComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    MatButtonModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    FormsModule,
    MatListModule,
    MatTableModule,
    BrowserAnimationsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
