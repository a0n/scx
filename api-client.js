#!/usr/bin/env node
import { Command } from 'commander';
import axios from 'axios';
const apiClient = new Command();

const URL = "https://jsonplaceholder.typicode.com"

apiClient
  .name('api-client')
  .description(`API client for ${URL}`)
  .option('-r, --resource <name>', 'name resource to act upon', 'todos');

apiClient.command('list')
  .alias('get')
  .description('list or get a resource')
  .option('-i, --id <identifier>', 'id of the resource to get', (value) => {
    return value.split(',').map((id) => {
      let range = id.match(/^([0-9]+)-([0-9]+)$/)
      if (range) {
        let ids = [];
        for(let i = parseInt(range[1]); i <= parseInt(range[2]); i++) { ids.push(i) };
        return ids;
      }
      return [id];
    }).flat();
  })
  .action(async (options, command) => {
    let response;
    if (options.id)  {
      // this query parameter handling pattern will not scale
      // instead the server must implement more robust filtering and pagination
      const idQueryParams = options.id.map((id) => { return `id=${id}` }).join('&');
      response = await axios.get(`${URL}/${command.parent.opts().resource}?${idQueryParams}`);
    } else {
      response = await axios.get(`${URL}/${command.parent.opts().resource}`);
    }
    if (response.data.length == 1) {
      console.log(response.data[0]);
    } else {
      console.log(response.data);
    }
  });

apiClient.command('create')
  .description('create a resource')
  .action(async (options, command) => {
    const response = await axios.post(`${URL}/${command.parent.opts().resource}`);
    console.log(response.data);
  });

apiClient.command('delete')
  .description('delete a resource')
  .requiredOption('-i, --id <identifier>', 'id of the resource to delete')
  .action(async (options, command) => {
    const response = await axios.delete(`${URL}/${command.parent.opts().resource}/${options.id}`);
    console.log(response.data);
  });

apiClient.parse();