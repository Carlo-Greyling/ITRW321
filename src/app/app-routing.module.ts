import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { StatScreenComponent } from './stat-screen/stat-screen.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home'},
  { path: 'home', component: HomeComponent },
  { path: 'appointment', component: StatScreenComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
