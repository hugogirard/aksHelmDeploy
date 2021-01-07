using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using TodoApi.Model;

namespace TodoApi.Controllers 
{
    [ApiController]
    [Route("api/[controller]")]
    public class TodoController : ControllerBase 
    {
        private readonly ILogger<TodoController> _logger;
        private readonly TodoContext _repository;

        public TodoController(ILogger<TodoController> logger,TodoContext context)
        {
            _logger = logger;
            _repository = context;
        }

        [HttpGet("all")]
        [ProducesResponseType(200,Type = typeof(IEnumerable<Todo>))]
        public async Task<IActionResult> All() 
        {
            var entities = await _repository.Todos.ToListAsync();

            return new OkObjectResult(entities);
        }

        [HttpGet()]
        [ProducesResponseType(200, Type = typeof(Todo))]
        [ProducesResponseType(404)]
        public async Task<IActionResult> GetById(int id) 
        {
            var entity = await _repository.Todos.SingleOrDefaultAsync(x => x.Id == id);

            if (entity == null)
                return NotFound();

            return new OkObjectResult(entity);
        }

        [HttpPost]
        [ProducesResponseType(200, Type = typeof(Todo))]        
        public async Task<IActionResult> Create([FromBody] Todo todo) 
        {
            await _repository.AddAsync(todo);

            return new OkObjectResult(todo);
        }

        [HttpPut]
        [ProducesResponseType(404)]
        [ProducesResponseType(200, Type = typeof(Todo))]
        public async Task<IActionResult> Update([FromBody] Todo todo) 
        {
            var entity = await _repository.Todos.SingleOrDefaultAsync(x => x.Id == todo.Id);

            if (entity == null)
                return NotFound();

            entity.Description = todo.Description;
            entity.Completed = todo.Completed;

            await _repository.SaveChangesAsync();

            return new OkObjectResult(entity);
        }

        [HttpDelete]        
        [ProducesResponseType(200)]
        public async Task<IActionResult> Delete([FromBody] Todo todo)
        {
            var entity = await _repository.Todos.SingleOrDefaultAsync(x => x.Id == todo.Id);

            if (entity == null)
                return NotFound();

            _repository.Remove(entity);

            await _repository.SaveChangesAsync();

            return Ok();
        }
    }
}